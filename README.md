# To-Do List

## Overview

Each Web App can switch dynamically with both API
Each API are connected to the same PostgreSQL DB

The project can be run through Docker using Docker Compose

## Requirements

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Setup

To run the project you have to fulfill all the .env
First of all, rename the file `.env.example` to `.env` in the root folder and fulfill all the informations about the database.

#### - Web applications

In the folders `flutter-web` and `react-web`, rename the file `.env.example` to `.env`.

#### - API

In the folders `nest-api` and `java-api`, rename the file `.env.example` to `.env` and fulfill the database informations using the same as the root `.env` file.

## Start

Run this command :

```bash
docker compose up --build -d
```

> :warning: **The build takes a long time to finish**, it will be faster if you have a good internet connection

## Links

- [Flutter](https://flutter.dev/) Web App should be available on http://localhost:3000

- [React](https://react.dev/) Web App should be available on http://localhost:3001

- [NestJS](https://nestjs.com/) API should be available on http://localhost:8080

- [Java Spring Boot](https://spring.io/) API should be available on http://localhost:8081

#### Credits

- [Pierre Lavergne](https://github.com/PierreLavergne) - 32lapi1mst@hft-stuttgart.de
- [Thomas Koebel](https://github.com/koebelt) - 32koth1mst@hft-stuttgart.de
- [Marvin Flamand](https://github.com/MarvinFlm) - 32flma1mst@hft-stuttgart.de
