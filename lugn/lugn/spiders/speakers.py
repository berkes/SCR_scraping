import scrapy
import re

class SpeakersSpider(scrapy.Spider):
    name = "speakers"
    allowed_domains = ["linuxnijmegen.nl"]
    start_urls = ["https://linuxnijmegen.nl/onderwerpen"]

    def parse(self, response):
        # Find all topics Links
        for topic in response.css('div.uk-grid .el-item a.uk-card'):
            yield response.follow(topic, self.parse_topic)

        if response.xpath('//h2[normalize-space()="Andere Onderwerpen"]'):
            parse_topic(response)

    def parse_topic(self, response):
        pres_by = response.xpath('//div[contains(text(), "Presentatie door:")]')
        topic = response.xpath('//h1/text()').get().strip()

        if pres_by:
            pres_by = pres_by.xpath('text()').get().replace('Presentatie door: ', '')
            pres_by = re.split(r' en | & |, |/', pres_by)

            yield {
                'topic': topic,
                'presenters': pres_by,
            }
