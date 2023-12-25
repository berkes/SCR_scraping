import puppeteer from 'puppeteer';

(async () => {
  // Launch the browser and open a new blank page
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  // Navigate the page to a URL
  await page.goto('https://ns.nl/reisinformatie/actuele-situatie-op-het-spoor/');

  // Set screen size
  await page.setViewport({ width: 1080, height: 1024 });

  const disruptionSel = await page.waitForSelector(
    '.ns-web-disruption-legend-item.ns-web-disruption-legend-item-disruptions'
  );
  const disruptionText = await disruptionSel.evaluate((el) => el.innerText);
  const maintSel = await page.waitForSelector(
    '.ns-web-disruption-legend-item.ns-web-disruption-legend-item-maintenances'
  );
  const maintText = await maintSel.evaluate((el) => el.innerText);

  console.log('Actuele situatie op het spoor:', disruptionText);
  console.log('Gepland onderhoud:', maintText);


  await browser.close();
})();
