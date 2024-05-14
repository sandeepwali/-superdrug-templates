from pydantic import BaseModel, HttpUrl
import requests

class ArticleMapping(BaseModel):
    articleId: str
    eans: list[str]
    stationCode: str

class MappingList(BaseModel):
    mappingList: list[ArticleMapping]

def send_request(url: HttpUrl, data: MappingList):
    response = requests.post(url, json=data.dict())
    return response.json()

def main():
    # Example usage
    article_mappings = []
    article_mappings.append(ArticleMapping(articleId='B100001', eans=['1234567890'], stationCode='ST00943'))
    article_mappings.append(ArticleMapping(articleId='B100002', eans=['2345678901'], stationCode='ST00944'))
    article_mappings.append(ArticleMapping(articleId='B100003', eans=['3456789012'], stationCode='ST00945'))
    mapping_list = MappingList(mappingList=article_mappings)
    print(mapping_list.model_dump_json())

if __name__ == "__main__":
    main()




