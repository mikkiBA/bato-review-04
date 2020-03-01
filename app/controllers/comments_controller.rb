class CommentsController < ApplicationController
    def index
    end

    def show
        @article = Article.find(params[:article_id])
        @starave = Comment.average(:restars)
    end
    
    def new
    end
    
    def create
       @article = Article.find(params[:article_id])
       @comment = @article.comments.create(comment_params)
       redirect_to article_path(@article)
    end
    
    def edit
    end
    
    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article)
    end
    
     private
     
     #カラム追加した後ここの許可を忘れるとストロングパラメータに引っかかってDBに保存できない
       def comment_params
         params.require(:comment).permit(:commenter, :body, :restars)
       end
end
