import scrapy

class CarSpider(scrapy.Spider):
    name = 'car'
    allowed_domains = []
    start_urls = []


    def parse(self,response):
        for seri in response.xpath("//ul[@class='category-facet-selection-wrapper ']/li/ul/li/div/a/@href").extract():
            link = response.urljoin(seri)
            yield scrapy.Request(link, callback=self.seri)

    def seri(self,response):
        for alt_seri in response.xpath("//li[@class='category-facet-selection-item inside-li  ']/div/a/@href").extract():
            alt_seri_arabalar = response.urljoin(alt_seri)
            yield scrapy.Request(alt_seri_arabalar, callback=self.alt_model)

    def alt_model(self,response):
        alt_model_page = response.xpath("//li[@class='category-facet-selection-item inside-li selected-list-item ']/ul/li/div/a/@href").extract()
        for alt_model in alt_model_page:
            alt_model_page_link = response.urljoin(alt_model)
            yield scrapy.Request(url=alt_model_page_link, callback=self.info)

    def info(self, response):
        for href in response.xpath("//h3[@class='crop-after']/a/@href").extract():
            url = response.urljoin(href)
            yield scrapy.Request(url, callback=self.ilan_page)

        next_page = response.xpath("//*[@id='pagingNext']/@href").get()
        if next_page is not None:
            full_link = response.urljoin(next_page)
            yield scrapy.Request(url=full_link, callback=self.info)

    def ilan_page(self, response):
        price = response.xpath(".//*[@id='js-hook-for-observer-detail']/div[2]/div[1]/div/span/text()").get()
        ilan_no = response.xpath("//*[@id='js-hook-for-observer-detail']/div[2]/ul/li[1]/span[2]/text()").get().strip()
        ilan_tarihi = response.xpath("//*[@id='js-hook-for-observer-detail']/div[2]/ul[1]/li[2]/span[2]/text()").get().strip()
        marka = response.xpath("//*[@id='js-hook-for-observer-detail']/div[2]/ul[1]/li[3]/span[2]/text()").get().strip()
        seri = response.xpath("//*[@id='js-hook-for-observer-detail']/div[2]/ul[1]/li[4]/span[2]/text()").get().strip()
        model = response.xpath("//*[@id='js-hook-for-observer-detail']/div[2]/ul[1]/li[5]/span[2]/text()").get().strip
        yil = int(response.xpath("//*[@id='js-hook-for-observer-detail']/div[2]/ul[1]/li[6]/span[2]/text()").get().strip())
        yakit_tipi = response.xpath('//*[@id="js-hook-for-observer-detail"]/div[2]/ul[1]/li[7]/span[2]/text()').get().strip()
        vites_tipi = response.xpath('//*[@id="js-hook-for-observer-detail"]/div[2]/ul[1]/li[8]/span[2]/text()').get().strip()
        motor_hacmi = response.xpath('//*[@id="js-hook-for-observer-detail"]/div[2]/ul[1]/li[9]/span[2]/text()').get().strip()
        motor_gucu = response.xpath('//*[@id="js-hook-for-observer-detail"]/div[2]/ul[1]/li[10]/span[2]/text()').get().strip()
        kilometre = response.xpath('//*[@id="js-hook-for-observer-detail"]/div[2]/ul[1]/li[11]/span[2]/text()').get()
        sasi_num = response.xpath('//*[@id="js-hook-for-observer-detail"]/div[2]/ul[1]/li[12]/span[2]/text()').get()
        plaka = response.xpath('//*[@id="js-hook-for-observer-detail"]/div[2]/ul[1]/li[13]/span[2]/text()').get()
        boya_degisen = response.xpath('//*[@id="js-hook-for-observer-detail"]/div[2]/ul[1]/li[14]/span[2]/text()').get()
        kimden = response.xpath('//*[@id="js-hook-for-observer-detail"]/div[2]/ul[1]/li[16]/span[2]/text()').get()


        yield {
            'fiyat':price,
            'ilan_no':ilan_no,
            'ilan_tarihi':ilan_tarihi,
            'marka':marka,
            'seri':seri,
            'model':model,
            'yil':yil,
            'yakit_tipi':yakit_tipi,
            'vites_tipi':vites_tipi,
            'motor_hacmi':motor_hacmi,
            'motor_gucu':motor_gucu,
            'kilometre':kilometre,
            'sasi_num':sasi_num,
            'plaka':plaka,
            'boya_degisen':boya_degisen,
            'kimden':kimden
        }


        for seri in response.xpath("//ul[@class='category-facet-selection-wrapper ']/li/ul/li/div/a/@href").extract():
            link = response.urljoin(seri)
            yield scrapy.Request(link, callback=self.alt_seri)

    def seri_page(self,response):
        for seri in response.xpath("//ul[@class='category-facet-selection-wrapper ']/li/ul/li/div/a/@href").extract():
            link = response.urljoin(seri)
            yield scrapy.Request(link, callback=self.alt_seri)