# 3A2S_System
**Setup**
- Install docker and docker-compose
- Clone repository

  `git clone git@github.com:thanhlong-dev/3A2S-System-api.git`
***
**Development**
- Build image
  
  `docker-compose build`

- Start server

  `docker-compose up`

- Seed data

  `docker-compose exec server rails db:seed`

***
**Open API**
- API Document
  `http://localhost:8002`