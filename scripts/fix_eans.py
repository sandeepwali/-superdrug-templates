from common import set_logger
from aims_saas_api_client import AIMSSaaSAPIClient
from aims_saas_articles_mapping import ArticleMapping, MappingList

def calculate_ean8_checksum(ean8_body):
    """ Calculate the EAN-8 checksum for the first 7 digits. """
    weights = [3, 1]  # Alternating weights in reverse order
    sum_ean = sum(int(ean8_body[i]) * weights[i % 2] for i in range(6, -1, -1))
    return (10 - (sum_ean % 10)) % 10

def padding_to_ean13(wrong_digit_ean13):
    """ Padding EAN-13 by adding 0 in front of the EAN-12. """
    return  wrong_digit_ean13.zfill(13)


def generate_ean8(article_id):
    """ Generate an EAN-8 barcode from an article ID. """
    # Ensure the article ID is at least 7 digits, pad with zeros if needed
    ean8_body = str(article_id).zfill(7)
    # Calculate the checksum digit
    checksum = calculate_ean8_checksum(ean8_body)
    # Return the full EAN-8 code
    return ean8_body + str(checksum)

def check_ean_lengths(article_eans):
    # Loop through each EAN in the list
    for ean in article_eans:
        # Check if the length of EAN is either 8 or 13
        if len(ean) == 8 or len(ean) == 13:
            return True
    # Return False if no EAN of the correct length is found
    return False

def find_wrong_digit_ean13(article_eans):
    for ean in article_eans:
        # Check if the lenght of EAN is 12
        if len(ean) > 8 and len(ean) < 13:
            return ean
        
    # Return False if no EAN of the correct length is found
    return None

def main():
    client = AIMSSaaSAPIClient()
    client.authenticate()
    logger.info(f"Authenticated successfully with session token {client.access_token}.")
    
    logger.info(f"Getting detail article information from company {client.company} and store {client.store}.")


    article_mappings = []

    articles = client.get_articles()


    #
    # Test code
    #
    #search_article_id = "734747"
    #search_article_id = "734697"
    #params = {"id": search_article_id}
    #articles = client.get_articles(params=params)

    #params = {"articleId": article_id}
    #article_details = client.get_article_details(params=params)
    #article_details

    
    logger.info(f"Found {len(articles)} articles.")
    for article in articles:
        
        # Get the article ID
        article_id = article.get("articleId")
        article_eans = article.get("EANs") or []

        # Guard clauses (input validation)
        if article_id is None:
            logger.error(f"Article ID is missing for article {article}.")
            continue
        if len(article_id) != 6:
            logger.debug(f"Article ID {article_id} is not 6 digits long.")
            continue
        if not article_id.isdigit():
            logger.debug(f"Article ID {article_id} is not numeric.")
            continue
        if check_ean_lengths(article_eans):
            logger.debug(f"Article ID {article_id} has at least one EAN {article_eans} of the correct length.")
            continue

        unique_eans = set(article_eans)
        wrong_digit_ean13 = find_wrong_digit_ean13(article_eans)
        if wrong_digit_ean13:
            ean_13 = padding_to_ean13(wrong_digit_ean13)
            unique_eans.add(ean_13)
        else:
            # Convert to ean8
            ean8_code = generate_ean8(article_id)
            # Merge the article eans, deduplicate and add new code using a set
            unique_eans.add(ean8_code)

        logger.info(f"Updating EANS for article {article_id} with {unique_eans}.")

        # Create the article mapping
        article_mapping = ArticleMapping(articleId=article_id, eans=unique_eans, stationCode=client.store)
        article_mappings.append(article_mapping)

        # If article_mapping.lenght >= 1000 then send the request
        if len(article_mappings) >= 1000:
            logger.info(f"Sending {len(article_mappings)} mappings to the server.")
            mapping_list = MappingList(mappingList=article_mappings)
            client.post_articles_mappinginfo(mapping_list=mapping_list)
            article_mappings = []

    # Send the remaining mappings
    if len(article_mappings) > 0:
        logger.info(f"Sending {len(article_mappings)} mappings to the server.")
        mapping_list = MappingList(mappingList=article_mappings)
        client.post_articles_mappinginfo(mapping_list=mapping_list)
        article_mappings = []



if __name__ == "__main__":
    # Set logger
    logger = set_logger(log_file='./scripts/logs/fix_eans.log')
    main()
