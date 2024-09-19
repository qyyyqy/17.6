#!/bin/bash
count_strings() {
	echo "$1" | awk 'END {print NR}'
}

count_unique_ip() {
	echo "$1" | awk '{count[$1]++} END {print length(count)}'
}

count_methods() {
	echo "$1" | awk '{methods[$6]++} END {for (method in methods) print substr(method, 2), methods[method]}'
}

popular_url() {
	echo "$1" | awk '{urls[$7]++} END {
		max_value=0
		max_url=""
		for (url in urls) {
			if (max_value < urls[url]) {
				max_value = urls[url]
				max_url = url
			}
		}
		print max_url, max_value
	}'
}

address=$(cat access.log)
> report.txt
echo "Отчёт о логе веб-сервера
========================

Общее количество запросов: " >> report.txt
count_strings "$address" >> report.txt
echo "Количество уникальных IP-адресов: " >> report.txt
count_unique_ip "$address" >> report.txt
echo "Количество запросов по методам: " >> report.txt
count_methods "$address" >> report.txt
echo "Самый популярный URL: " >> report.txt
popular_url "$address" >> report.txt
echo "Отчёт сохранён в report.txt"