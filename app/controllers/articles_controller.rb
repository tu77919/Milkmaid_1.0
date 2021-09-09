class ArticlesController < ApplicationController
  def show
    #byebug
  	@article = Article.find(params[:id])                                                             #Take Article class and find passed in parameter ID and store to INSTANCE variable to be used outside of method
  end
  def index
    @articles = Article.all                                                                         #Take Article class, using all method and gather all articles in the table and pass to INSTANCE Variable to be used in index page
  end
  def new
    @article = Article.new()
  end
  def edit
    @article = Article.find(params[:id])                                                            #Use the Article.find() Class and method with the passed in Params hash to find ID and use in the url
  end
  def create
    #very simple type of info pulling in debug sort of way.
    #render plain: params[:article]

    @article = Article.new(params.require(:article).permit(:title, :description))                   #Create method called by post call from form submit button chain methods from passed in params object to obtain desired fields and set them up to written to db
    #checking content of form in real time upon submit - inspect object and obtain all fields
    #render plain: @article.inspect

    if @article.save                                                                                #Save the Schizzy to the db
      flash[:notice] = "Article was created successfully."                                          #Flash for successful save to db indicating so
      #After Save, tell rails to goto the show page for this new article 
      #redirect_to article_path(@article)                                                           #redirect to the articlespath/id; the path to the show page for this article (id can be divined from the instance variable)
      redirect_to @article                                                                          #another way to redirect to article_path is to divine article_path from instance varialbe the method with give you the ID needed
    else
      render 'new'
    end
  end
  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end
end
