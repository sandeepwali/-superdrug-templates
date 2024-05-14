import requests
from requests.exceptions import HTTPError
import json
import os
from dotenv import load_dotenv

from aims_saas_articles_mapping import MappingList

load_dotenv()

class AIMSSaaSAPIClient:
    BASE_URL = os.getenv('AIMS_SAAS_URL')

    def __init__(self):
        self.username = os.getenv('AIMS_SAAS_USERNAME', None)
        self.password = os.getenv('AIMS_SAAS_PASSWORD', None)
        self.access_token = None
        self.refresh_token = None
        self.company = os.getenv('AIMS_SAAS_COMPANY', None)
        self.store = os.getenv('AIMS_SAAS_STORE', None)
        self.authorization = None
        self.accept = 'application/json'
        self.page = 0
        self.size = 10

    def _get(self,endpoint,headers:dict=None,params:dict=None):

        if not self.authorization:
            raise ValueError("Token not set. Please authenticate before making requests.")

        if params is None:
            params = {}
        if 'company' not in params:
            params['company'] = self.company

        if headers is None:
            headers = {}
        if 'accept' not in headers:
            headers['accept'] = self.accept
        if 'Authorization' not in headers:
            headers['Authorization'] = self.authorization

        response = requests.get(endpoint, headers=headers, params=params)

        return response

    def _post(self,endpoint,headers:dict=None,params:dict=None,json:dict=None):
        if not self.authorization and endpoint != f"{self.BASE_URL}/api/v2/token":
            raise ValueError("Token not set. Please authenticate before making requests.")

        if params is None:
            params = {}

        if headers is None:
            headers = {}
        if 'accept' not in headers:
            headers['accept'] = self.accept
        if 'Authorization' not in headers:
            headers['Authorization'] = self.authorization

        response = requests.post(endpoint, params=params, headers=headers, json=json)
        return response
    
    def _delete(self,endpoint,headers:dict=None,params:dict=None,json:dict=None):
        if not self.authorization and endpoint != f"{self.BASE_URL}/api/v2/token":
            raise ValueError("Token not set. Please authenticate before making requests.")

        if params is None:
            params = {}

        if headers is None:
            headers = {}
        if 'accept' not in headers:
            headers['accept'] = self.accept
        if 'Authorization' not in headers:
            headers['Authorization'] = self.authorization

        response = requests.delete(endpoint, params=params, headers=headers, json=json)
        return response

    def next_page(self):
        self.page += 1
        return None

    def reset_page(self):
        self.page = 0
        return None

    def set_authorization(self, token):
        self.authorization = f"Bearer {token}"
        return None

    def set_company(self, company:str):
        self.company = company
        return None

    def set_store(self, store:str):
        self.store = store
        return None

    def set_page(self, page:int):
        self.page = page
        return None

    def set_size(self, size:int):
        self.size = size
        return None

    def get_company(self):
        return self.company

    def get_store(self):
        return self.store

    def get_page_str(self):
        return str(self.page)

    def get_size_str(self): 
        return str(self.size)

    def authenticate(self):
        """
        Retrieve the authentication token using the provided username and password.
        """
        endpoint = f"{self.BASE_URL}/api/v2/token"

        headers = {
            'accept': 'application/json',
            'Content-Type': 'application/json'
        }

        json = {
            "username": self.username,
            "password": self.password
        }

        response = self._post(endpoint, headers=headers, json=json)
        if response.status_code == 200:
            self.access_token = response.json()["responseMessage"]["access_token"]
            self.set_authorization(self.access_token)
            self.refresh_token = response.json()["responseMessage"]["refresh_token"]
        else:
            response.raise_for_status()

        return None

    def get_article_upload_format(self, params:dict=None, headers:dict=None)->dict:
        """
        Get article upload format
        """
        if not self.access_token:
            raise ValueError("Token not set. Please authenticate before making requests.")

        endpoint = f"{self.BASE_URL}/api/v2/common/articles/upload/format"

        response = self._get(endpoint, headers=headers, params=params)
        if response.status_code in (200,202):
            return response.json()
        else:
            # 401,403,405
            response.raise_for_status()

    def get_articles(self, params:dict=None, headers:dict=None, max_x_total_pages:int=None)->list:
        """
        Get article upload format
        """

        if not self.access_token:
            raise ValueError("Token not set. Please authenticate before making requests.")

        article_list = []
        self.reset_page()
        self.size = 500

        if params is None:
            params = {}
        if 'store' not in params:
            params['store'] = self.store
        if 'page' not in params:
            params['page'] = self.get_page_str()
        if 'size' not in params:
            params['size'] = self.get_size_str()

        endpoint = f"{self.BASE_URL}/api/v2/common/articles"

        response = self._get(endpoint, headers=headers, params=params)

        if response.status_code in (200,202):
            article_list.extend(response.json().get("articleList"))
        else:
            # 401,403,405
            response.raise_for_status()

        # Check if there are more pages and append the articles to the list
        x_total_pages = response.headers.get("x-totalPages")

        if max_x_total_pages is not None and int(x_total_pages) > max_x_total_pages:
            x_total_pages = max_x_total_pages

        if x_total_pages and max==True:
            x_total_pages = "5" # debug purposes
        while int(self.page) < int(x_total_pages) - 1:
            self.next_page()
            params['page'] = self.get_page_str()
            response = self._get(endpoint, headers=headers, params=params)
            article_list.extend(response.json().get("articleList"))

        self.reset_page()
        return article_list
    
    def get_article_details(self, params:dict=None, headers:dict=None)->list:
        """
        Get article upload format
        """

        if not self.access_token:
            raise ValueError("Token not set. Please authenticate before making requests.")

        article_list = []
        self.reset_page()
        self.size = 100

        if params is None:
            params = {}
        if 'store' not in params:
            params['store'] = self.store
        if 'page' not in params:
            params['page'] = self.get_page_str()
        if 'size' not in params:
            params['size'] = self.get_size_str()

        endpoint = f"{self.BASE_URL}/api/v2/common/config/article/info"

        response = self._get(endpoint, headers=headers, params=params)

        if response.status_code in (200,202):
            article_list.extend(response.json().get("articleList"))
        else:
            # 401,403,405
            response.raise_for_status()

        # Check if there are more pages and append the articles to the list
        x_total_pages = response.headers.get("x-totalPages")
        #x_total_pages = "5" # debug purposes
        while int(self.page) < int(x_total_pages) - 1:
            self.next_page()
            params['page'] = self.get_page_str()
            response = self._get(endpoint, headers=headers, params=params)
            article_list.extend(response.json().get("articleList"))

        self.reset_page()
        return article_list

    def post_articles_mappinginfo(self, mapping_list:MappingList, params:dict=None, headers:dict=None):
        """
        Post article mapping info
        """

        if not self.access_token:
            raise ValueError("Token not set. Please authenticate before making requests.")

        if params is None:
            params = {}
        if 'company' not in params:
            params['company'] = self.company
        #if 'store' not in params:
        #    params['store'] = self.store

        endpoint = f"{self.BASE_URL}/api/v1/articles/mappinginfo"

        response = self._post(endpoint=endpoint, headers=headers, params=params, json=mapping_list.model_dump())
        if response.status_code not in (200,202):
            # 401,403,405
            response.raise_for_status()
    
    def delete_articles(self, articles_ids:list, params:dict=None, headers:dict=None, chunk_size:int=1000):

        if params is None:
            params = {}
        if 'company' not in params:
            params['company'] = self.company
        if 'store' not in params:
            params['store'] = self.store

        endpoint = f"{self.BASE_URL}/api/v2/common/articles"

        # chunk the article_ids into chunks of size chunk_size
        for i in range(0, len(articles_ids), chunk_size):
            data = {"articleDeleteList": articles_ids[i:i + chunk_size]}
            response = self._delete(endpoint=endpoint, headers=headers, params=params, json=data)
            if response.status_code not in (200,202):
                # 401,403,405
                response.raise_for_status()
       
    def unlink_label(self, label_code):
        """
        Unlink a label for a given company and label code.
        """
        if not self.access_token:
            raise ValueError("Token not set. Please authenticate before making requests.")

        endpoint = f"{self.BASE_URL}/api/v1/labels/unlink"
        params = {
            "company": self.company,
            "labelCode": label_code
        }

        headers = {
            'accept': 'application/json',
            'Authorization' : f"Bearer {self.access_token}"
        }

        response = requests.post(endpoint, headers=headers, params=params)
        if response.status_code in (200,202):
            return response.json()
        else:
            # 401,403,405
            response.raise_for_status()

def main():
    company="SEG"
    label_code="05F0A1B4B09C"
    # Example of how to use the API client:
    client = AIMSSaaSAPIClient()
    access_token = client.authenticate()
    print(f"Retrieved Access Token: {access_token}")
    print(f"Retrieved Refresh Token: {client.refresh_token}")

    try:
        result = client.unlink_label(company=company, label_code=company)
        print(f"Unlink result: {result}")
    except HTTPError as http_err:
        print(f"HTTP error occurred while unlinking label {label_code} for company {company}. Error: {http_err}, Response: {http_err.response.text}")
    except Exception as e:
        print(f"Error unlinking label {label_code} for company {company}. Error: {e}")


if __name__ == "__main__":
    main()
