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
    char result[20];
    result[0] = 0;
    strcat(result, "\033[");
    if (state.bold == 1)
        strcat(result, "1");
    else
        strcat(result, "0");

    strcat(result, ";");

    char* color_number = new_itoa(30 + state.color);
    strcat(result, color_number);
    free(color_number);

    strcat(result, "m");

    return strdup(result);
}

char* colorize_node(xmlDocPtr doc, xmlNodePtr cur, style_state state)
{
    char* res = NULL;

    while (cur)
    {
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
            if (xmlStrcmp(cur->name, (const xmlChar *)"green") == 0)
                new_state.color = 2;
            if (xmlStrcmp(cur->name, (const xmlChar *)"yellow") == 0)
                new_state.color = 3;
            if (xmlStrcmp(cur->name, (const xmlChar *)"blue") == 0)
                new_state.color = 4;

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

    cur = cur->xmlChildrenNode;
    style_state state;
    state.color = 7;
    state.bold  = 0;

    char* result, *nodes;

    result = state_to_escape(state);
    nodes = colorize_node(doc, cur, state);
    appendstr(&result, nodes);
    free(nodes);

    appendstr(&result, "\033[0m");

    xmlFreeDoc(doc);
    return result;
}
