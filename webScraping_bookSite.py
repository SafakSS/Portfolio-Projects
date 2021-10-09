import scrapy
from scrapy import Request


class CokSatanlarSpider(scrapy.Spider):
    name = 'cok_satanlar'
    allowed_domains = ['']
    start_urls = ['']
    #start_urls = ['']

    def parse(self, response):
        kitaplar = response.xpath("//div[@class='prd-inner itemWrap']")
        for kitap in kitaplar:
            kitap_adi = kitap.xpath(".//h3[@class='book-name']/text()").get()
            resim_link = response.xpath("//div[@class='prd-image-org']/img/@src").get()
            yayinevi = response.xpath("//span[@class='distributor-name']/text()").get()
            yazar = response.xpath("//div[@class='authorArea']/div/a/span[@class='manufacturer-name']/text()").get()
            indirim_orani = response.xpath("//span[@class='redDiscont']/text()").get().strip().replace('%','')
            brut_fiyat_tam = response.xpath("//div[@class='urunListe_brutFiyat']/text()").get().strip()
            brut_fiyat_kusurat = response.xpath("//div[@class='urunListe_brutFiyat']/span/text()").get()
            brut_fiyat = brut_fiyat_tam+brut_fiyat_kusurat
            satis_fiyat_tam = response.xpath("//div[@class='urunListe_satisFiyat']/text()").get().strip()
            satis_fiyat_kusurat = response.xpath("//div[@class='urunListe_satisFiyat']/span/text()").get()
            satis_fiyat = satis_fiyat_tam+satis_fiyat_kusurat

            yield{
                'kitap_ismi' : kitap_adi,
                'resim_link' : resim_link,
                'yayinevi'   : yayinevi,
                'yazar': yazar,
                'indirim_orani' : indirim_orani,
                'bruf_fiyat' : brut_fiyat,
                'satis_fiyat': satis_fiyat
            }
        next_page = response.xpath("//a[@id='ctl00_u8_ascUrunList_ascPagingDataAlt_lnkNext']/@href").get()
        if next_page:
            full_link = response.urljoin(next_page) 
            print(full_link)
            yield scrapy.Request(url=full_link, callback=self.parse)

