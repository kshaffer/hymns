import requests
from bs4 import BeautifulSoup
from bs4 import UnicodeDammit

def write_to_file(filename, data):
    f = open(filename, 'wb')
    f.write(data)
    f.close()

hymn = requests.get('http://www.hymnary.org/hymn/TH1990/1')
soup = BeautifulSoup(hymn.text, 'lxml')
lyrics = soup.find(id='text').get_text() #.replace('\r', ' ').replace('\n', ' ').replace('  ', ' ')
print(lyrics)

