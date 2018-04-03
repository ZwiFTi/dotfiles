import requests
import math
from tabulate import tabulate

# TODO: Auto order by market cap
# TODO: Keep script running every 5 minutes


# Math helper function
millnames = ['',' Thousand',' Million',' Billion',' Trillion']

def millify(n):
    n = float(n)
    millidx = max(0,min(len(millnames)-1,
        int(math.floor(0 if n == 0 else math.log10(abs(n))/3))))
    return '{:.0f}{}'.format(n / 10**(3 * millidx), millnames[millidx])

# Insert the coins you want to watch
coins = ['bitcoin', 'ethereum', 'ripple', 'cardano', 'stellar', 'vechain']
tab = []

# tab list gets populated
for coin in coins:
    r = requests.get(
            "http://api.coinmarketcap.com/v1/ticker/" + coin + "/")
    price = ("%.2f" % float(r.json()[0]["price_usd"]))
    marketcap = millify(float(r.json()[0]["market_cap_usd"]))
    tab.append([coin, price, marketcap])

# and used to present a neat table of information
print tabulate(tab, headers=['Coin', 'Price', 'Market Capitalisation'])

