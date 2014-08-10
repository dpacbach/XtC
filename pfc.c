#include <stdio.h>
#include <string.h>
#include <libxml/xmlreader.h>
#include <libxml/parser.h>

#include "pfc.h"
#include "strextra.h"

typedef struct {
    char color;
    int bold;
} style_state;

char* state_to_escape(style_state state)
{
    char* result;
    if (state.color == 1  && state.bold == 1)
        result = "\033[1;31m";
    if (state.color == -1 && state.bold == 1)
        result = "\033[0;1m";
    if (state.color == 1  && state.bold == 0)
        result = "\033[0;31m";
    if (state.color == -1 && state.bold == 0)
        result = "\033[0m";
    return strdup(result);
}

char* colorize_node(xmlDocPtr doc, xmlNodePtr cur, style_state state)
{
    char* res = NULL;

    while (cur)
    {
        //printf("Found node: %s", cur->name);
        if (xmlNodeIsText(cur) == 1)
        {
            xmlChar* text = xmlNodeGetContent(cur);
            appendstr(&res, text);
            xmlFree(text);
        }
        else
        {
            if (cur->children == NULL)
                printf("ERROR: cur->children == NULL\n");

            style_state new_state = state;
            if (xmlStrcmp(cur->name, (const xmlChar *)"b") == 0)
                new_state.bold = 1;
            if (xmlStrcmp(cur->name, (const xmlChar *)"red") == 0)
                new_state.color = 1;

            char* escape_str;
            escape_str = state_to_escape(new_state);
            appendstr(&res, escape_str);
            free(escape_str);

            xmlChar* content = colorize_node(doc, cur->children, new_state);
            appendstr(&res, (char*)content);
            xmlFree(content);

            escape_str = state_to_escape(state);
            appendstr(&res, escape_str);
            free(escape_str);
        }
        cur = cur->next;
    }

    return res;
}

char* colorize(char* input)
{
    xmlDocPtr doc;
    xmlNodePtr cur;

    xmlChar* xmlInput = xmlCharStrdup(input);
    doc = xmlParseDoc(xmlInput);
    xmlFree(xmlInput);

    if (!doc)
    {
        fprintf(stderr, "Document not parsed correctly\n");
        return NULL;
    }

    cur = xmlDocGetRootElement(doc);

    if (!cur)
    {
        fprintf(stderr, "Empty Document\n");
        xmlFreeDoc(doc);
        return NULL;
    }

    if (xmlStrcmp(cur->name, (const xmlChar *)"coloredtext"))
    {
        fprintf(stderr, "Incorrect document type\n");
        xmlFreeDoc(doc);
        return NULL;
    }

    char* result;

    cur = cur->xmlChildrenNode;
    style_state state;
    state.color = -1;
    state.bold  = 0;
    result = colorize_node(doc, cur, state);

    xmlFreeDoc(doc);
    return result;
}
