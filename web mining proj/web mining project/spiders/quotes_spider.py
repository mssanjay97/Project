""" import scrapy


class QuotesSpider(scrapy.Spider):
    name = "quotes"
    start_urls = [
        'http://quotes.toscrape.com/page/1/',
        'http://quotes.toscrape.com/page/2/',
    ]

    def parse(self, response):
        for quote in response.css('div.quote'):
            yield {
                'text': quote.css('span.text::text').extract_first(),
                'author': quote.css('small.author::text').extract_first(),
                'tags': quote.css('div.tags a.tag::text').extract(),
            }

"""

import scrapy
import datetime
import sys

class QuotesSpider(scrapy.Spider):
    name = "quotes"
    start_urls = [
        #'http://quotes.toscrape.com/page/1/',
        'http://vit.ac.in',
    ]
    
    def parse(self, response):
        for quote in response.xpath('//title'):
            q=quote.xpath('.//text()').extract()
            for tit in q:
                yield {
                    'title': tit,                
                }

        next_page = response.css('a::attr(href)').extract()
        print(next_page)
        now= datetime.datetime.now()
        if now.minute > 59:
            sys.exit("terminating program!!!!!!!")
        for np in next_page:
            yield response.follow(np, callback=self.parse)



