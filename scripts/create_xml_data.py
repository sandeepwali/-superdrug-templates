from common import set_logger
from aims_saas_api_client import AIMSSaaSAPIClient

import csv

from lxml import etree

def get_article_ids_from_csv(filename:str)->list:
    article_ids = []
    with open(filename, 'r') as file:
        reader = csv.DictReader(file, delimiter=';')
        for row in reader:
            article_id = row['article_id']
            article_ids.append(article_id)

    return article_ids

def out_file(file,string):
    with open(file, 'w', encoding='utf-8') as file:
        file.write(string)

def create_xml_lxml(article_detail:dict):
    article_id = article_detail.get('articleId')
    article_data = article_detail.get('data')

    # Create the root element 'articles' with an attribute 'page'
    root = etree.Element("articles", page="1")

    # Add 'enddevice' element under the root
    enddevice = etree.SubElement(root, "enddevice")
    # Sub-elements under 'enddevice'
    etree.SubElement(enddevice, "labelCode").text = "LABEL_CODE"
    etree.SubElement(enddevice, "labelTypeCode").text = "labelTypeCode"
    etree.SubElement(enddevice, "arrow").text = "Arrow"

    # Add 'article' element with attribute 'index'
    article = etree.SubElement(root, "article", index="1")
    # 'data' element under 'article'
    data = etree.SubElement(article, "data")
    # Sub-elements under 'data'

    # Dynamically create sub-elements based on dictionary key-value pairs
    for key, value in article_data.items():
        tag = key
        etree.SubElement(data, tag).text = value

    # Convert the ElementTree to a string and pretty-print it
    xml_string = etree.tostring(root, pretty_print=True, xml_declaration=True, encoding='UTF-8', standalone="no")
    # Print the formatted XML string
    #print(xml_string.decode('utf-8'))

    out_file(f"./scripts/xml_data/{article_id}.xml", xml_string.decode('utf-8'))
    logger.info(f"Created XML file for article: {article_id} under ./scripts/xml_data/{article_id}.xml.")

    return


def export_article_details_to_xml(article_details:list):
    for article_detail in article_details:
        create_xml_lxml(article_detail)

    return None



def main():
    article_ids = get_article_ids_from_csv('./scripts/articles.csv')
    logger.info(f"Fetching number of articles: {len(article_ids)}")

    client = AIMSSaaSAPIClient()
    client.authenticate()
    logger.info(f"Authenticated successfully with session token {client.access_token}.")
    
    logger.info(f"Getting detail article information from company {client.company} and store {client.store}.")
    for article_id in article_ids:
        logger.info(f"Getting article details for article: {article_id}")
        params = {"articleId": article_id}
        article_details = client.get_article_details(params=params)
        logger.info(f"Fetched number of article details: {len(article_details)}")
        export_article_details_to_xml(article_details)


if __name__ == "__main__":
    # Set logger
    logger = set_logger(log_file='./scripts/logs/create_xml_data.log')
    main()

