class ReviewsController < ApplicationController

    
    def show
        @article = Article.find(params[:article_id])
        @starave = Comment.average(:restars)
    end
    
    def create
       @article = Article.find(params[:article_id])
       @review = @article.comments.create(comment_params)
       redirect_to article_path(@article)
     end

    def destroy
        @article = Article.find(params[:article_id])
        @review = @article.comments.find(params[:id])
        @review.destroy
        redirect_to article_path(@article)
    end
    
     private
     #カラム追加した後ここの許可を忘れるとストロングパラメータに引っかかってDBに保存できない
       def comment_params
         params.require(:comment).permit(:commenter, :body, :restars)
       end
end
