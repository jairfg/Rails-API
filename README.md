##  Rails-API
#### Diagrama 
![tdd-ruby](public/diagrama.png)

### Iniciar el proyecto
```
- Clonar repositorio
- bundle install
- rails db:setup
- rails server
```


#### Endpoints
```
GET /posts?search=title (optional query)
```
```
GET /posts/{id}
```
```
GET /posts/unpublished
```
```
POST /posts
```
```
PUT /posts/{id}
```
Gemas utilizadas:
* rspec (gem testing)
* factory bot (crear modelos falsos)
* faker (generar datos fake)
* letter_opener (visualizar mailer)

Adicionalmente implementé:
* Caching (busqueda de un post)
* ActiveJob (trabajo en segundo plano)
* ActiveMailer (enviar reporte)
```
#envio de reporte 
PostReportMailer.post_report(User.first, Post.first, PostReport.generate(Post.first)).deliver_now
```



