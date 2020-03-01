class ArticlesController < ApplicationController
    def index
        @articles = Article.all
        @titlelatest = Article.order(created_at: :desc).take
        @reviewlatest = Comment.order(created_at: :desc).take
        #limitはアクティブレコードのメソッドなので、帰ってくるのが配列じゃない
        #@latest02 = Article.order(created_at: :desc).limit(1)
    end
    #Railsではコントローラのインスタンス変数はすべてビューに渡されるようになっている
    def show
        @article = Article.find(params[:id])
        @starave = Comment.where(article_id: @article).average(:restars)
    end

    def new
        @article = Article.new
    end
    
    def edit
        @article = Article.find(params[:id])
    end
    
    def create
        #render plain: params[:article].inspectで見た取り出したい属性はparams[:article]の中にある
        #パラメータを安全に扱うために許可かつ必須にする
        #@Article = Article.new(params.require(:article).permit(:title, :text))
        @article = Article.new(article_params)
        
        #このモデルをデータベースに保存
        if @article.save
            redirect_to @article
        else
            render 'new'  #newテンプレートに対するrenderを実行
        end
    end
    
    def update
      @article = Article.find(params[:id])
     
      if @article.update(article_params)
        redirect_to @article
      else
        render 'edit'
      end
    end
    
     def destroy
       @article = Article.find(params[:id])
       @article.destroy
    
        #削除後にindexアクションにリダイレクト
       redirect_to articles_path
     end
        
    #他のアクションでも便利に使えるように、この許可と必須メソッドをくくり出す。不正呼び出し防止のため、private宣言
    private
        def article_params
            params.require(:article).permit(:title, :text)
        end
end
