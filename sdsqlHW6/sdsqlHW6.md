# Домашнее задание к занятию «Репликация и масштабирование. Часть 1»

### Задание 1

На лекции рассматривались режимы репликации master-slave, master-master, опишите их различия.

1. Master-Slave — способ организации базы данных, где есть один главный сервер (Master) и один или несколько подчинённых (Slave). Master принимает все запросы на запись (добавление, изменение, удаление данных), а Slaves только читают данные и получают обновления от Master.  
2. Master-Master — это когда у базы данных есть два (или больше) главных сервера, и каждый из них может одновременно принимать и обрабатывать запросы на запись и чтение. Данные между серверами автоматически синхронизируются, чтобы оставаться одинаковыми.  

---

### Задание 2

Выполните конфигурацию master-slave репликации, примером можно пользоваться из лекции.

![изображение](https://github.com/user-attachments/assets/f1626fb1-765e-4672-a45e-ae5a18d1b408)

<img width="944" alt="изображение" src="https://github.com/user-attachments/assets/946c73d0-b494-4dc6-a4aa-e4c6fca736f0" />

<img width="1283" alt="изображение" src="https://github.com/user-attachments/assets/23a894af-234c-49ce-8001-86f820e8c222" />

---

### Задание 3* 

Выполните конфигурацию master-master репликации. Произведите проверку.

![изображение](https://github.com/user-attachments/assets/71d74f7a-39e9-48a0-a052-58bb6669dfd0)

- master1:
<img width="1284" alt="изображение" src="https://github.com/user-attachments/assets/6c774ee0-90ad-4335-b8c4-ec9e9b9f1863" />

<img width="1280" alt="изображение" src="https://github.com/user-attachments/assets/75c3e619-0c3e-4475-9f1c-761aa1e90872" />

- master2:
<img width="1286" alt="изображение" src="https://github.com/user-attachments/assets/30cc6402-4cd8-421b-9b87-70a97dac5cbc" />

<img width="1279" alt="изображение" src="https://github.com/user-attachments/assets/ef49843b-138a-4fdb-9df8-8f595e018e6d" />
