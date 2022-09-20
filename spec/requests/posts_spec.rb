require "rails_helper"

RSpec.describe "Posts", type: :request do 
    
    #context: db is empty
    describe "GET /posts" do 
        before { get '/posts' }

        it "should return ok" do
            payload = JSON.parse(response.body)
            expect(payload).to be_empty
            expect(response).to have_http_status(200)
        end
    end

    describe "Search" do
        let!(:hola_mundo) { create(:published_post, title: 'Hola Mundo')}
        let!(:hola_rails) { create(:published_post, title: 'Hola Rails')}
        let!(:curso_rails) { create(:published_post, title: 'Curso Rails')}
        
        it "should filter posts by title" do
            get "/posts?search=Hola"
            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload.size).to eq(2)
            expect(payload.map { |p| p["id"] }.sort).to eq([hola_mundo.id, hola_rails.id].sort)
            expect(response).to have_http_status(200)
        end
    end

    # with data in the db
    describe "with data in the DB" do 
        let!(:posts) { create_list(:post, 10, published: true) } # dos formas , let y let! 
        before { get '/posts' }

        it "should return all the published posts" do 
            payload = JSON.parse(response.body)
            expect(payload.size).to eq(posts.size) 
            expect(response).to have_http_status(200)
        end
    end

    #show
    describe "GET /post/{id}" do 
        let(:post) { create(:post, published: true) }
        
        it "should return a post" do
            get "/posts/#{post.id}" 
            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload["id"]).to eq(post.id)
            expect(payload["title"]).to eq(post.title)
            expect(payload["content"]).to eq(post.content)
            expect(payload["published"]).to eq(post.published)
            expect(payload["author"]["name"]).to eq(post.user.name)
            expect(payload["author"]["email"]).to eq(post.user.email)
            expect(payload["author"]["id"]).to eq(post.user.id)
            expect(response).to have_http_status(200)
        end
    end

    #present data request
    # describe "POST /posts" do 
    #     let!(:user) { create(:user) }
    #     it "should create a post" do 
    #         req_payload = {
    #             post: {
    #                 title: "titulo",
    #                 content: "content",
    #                 published: false,
    #                 user_id: user.id
    #             }
    #         } 
    #         # POST HTTP
    #         post "/posts", params: req_payload
    #         payload = JSON.parse(response.body)
    #         expect(payload).to_not be_empty
    #         expect(payload["id"]).to_not be_nil
    #         expect(response).to have_http_status(:created)
    #     end

    #     it "should return error message on invalid post" do
    #         req_payload = {
    #             post: {
    #                 content: "content",
    #                 published: false,
    #                 user_id: user.id
    #             }
    #         }
    #         post "/posts", params: req_payload
    #         payload = JSON.parse(response.body)
    #         expect(payload).to_not be_empty
    #         expect(payload["error"]).to_not be_empty
    #         expect(response).to have_http_status(:unprocessable_entity)
    #     end
    # end

    # describe "PUT /posts/{id}" do 
    #     let!(:article) { create(:post)}

    #     it "should create a post" do
    #         req_payload = {
    #             post: {
    #                 title: "titulo",
    #                 content: "content",
    #                 published: true
    #             }
    #         }
    #         # PUT HTTP
    #         put "/posts/#{article.id}", params: req_payload
    #         payload = JSON.parse(response.body)
    #         expect(payload).to_not be_empty
    #         expect(payload["id"]).to eq(article.id)
    #         expect(response).to have_http_status(:ok)
    #     end


    #     it "should return error message on invalid post" do
    #         req_payload = {
    #             post: {
    #                 title: nil,
    #                 content: nil,
    #                 published: false
    #             }
    #         }
    #        # PUT HTTP
    #         put "/posts/#{article.id}", params: req_payload
    #         payload = JSON.parse(response.body)
    #         expect(payload).to_not be_empty
    #         expect(payload["error"]).to_not be_empty
    #         expect(response).to have_http_status(:unprocessable_entity)
    #     end
    # end
end