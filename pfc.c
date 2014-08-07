#include <stdio.h>
#include <string.h>
#include <libxml/xmlreader.h>

#include "pfc.h"

char* get_blue(char* input)
{
    xmlDocPtr doc;
    xmlNodePtr cur;

    xmlChar* xmlInput = xmlCharStrdup(input);

    doc = xmlParseDoc(xmlInput);

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

    char* result = NULL;

    cur = cur->xmlChildrenNode;
    while (cur)
    {
        if (!xmlStrcmp(cur->name, (const xmlChar *)"blue"))
        {
            xmlChar* text = xmlNodeListGetString(doc, cur->xmlChildrenNode, 1);
            if (text)
            {
                int length = strlen((const char*)text);
                result = (char*)malloc(sizeof(char)*length + 1);
                strcpy(result, (const char*)text);
                xmlFree(text);
                break;
            }
            else
            {
                fprintf(stderr, "Failed to extract text\n");
                xmlFreeDoc(doc);
                return NULL;
            }
        }
        cur = cur->next;
    }
    if (!cur)
        fprintf(stderr, "Failed to find blue node.\n");

    xmlFreeDoc(doc);
    return result;
}
