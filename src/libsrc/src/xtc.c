#include <stdio.h>
#include <string.h>
#include <libxml/xmlreader.h>
#include <libxml/parser.h>

#include "xtc/xtc.h"
#include "strextra.h"

typedef struct {
    char color;
    int bold;
} style_state;

static char* state_to_escape(style_state state)
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

static style_state update_state(xmlNodePtr cur, const style_state* state)
{
    style_state new_state = *state;

    if (xmlStrcmp(cur->name, (const xmlChar *)"b") == 0)
        new_state.bold = 1;

    if (xmlStrcmp(cur->name, (const xmlChar *)"black") == 0)
        new_state.color = 0;
    else if (xmlStrcmp(cur->name, (const xmlChar *)"red") == 0)
        new_state.color = 1;
    else if (xmlStrcmp(cur->name, (const xmlChar *)"green") == 0)
        new_state.color = 2;
    else if (xmlStrcmp(cur->name, (const xmlChar *)"yellow") == 0)
        new_state.color = 3;
    else if (xmlStrcmp(cur->name, (const xmlChar *)"blue") == 0)
        new_state.color = 4;
    else if (xmlStrcmp(cur->name, (const xmlChar *)"magenta") == 0)
        new_state.color = 5;
    else if (xmlStrcmp(cur->name, (const xmlChar *)"cyan") == 0)
        new_state.color = 6;
    else if (xmlStrcmp(cur->name, (const xmlChar *)"white") == 0)
        new_state.color = 7;
    return new_state;
}

static char* colorize_node(xmlDocPtr doc, xmlNodePtr cur, style_state state)
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
                fprintf(stderr, "ERROR: cur->children == NULL\n");

            style_state new_state = update_state(cur, &state);

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

char* xtc_colorize(char* input)
{
    xmlDocPtr doc;
    xmlNodePtr cur;

    int length = strlen(input);
    length += 27 + 1; // <coloredtext></coloredtext>\0
    char* doc_input = malloc(sizeof(char) * length);
    doc_input[0] = 0;
    sprintf(doc_input, "<coloredtext>%s</coloredtext>", input);

    xmlChar* xmlInput = xmlCharStrdup(doc_input);
    free(doc_input);
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
