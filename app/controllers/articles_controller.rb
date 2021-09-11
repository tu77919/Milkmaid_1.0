class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]                               #Ruby helper BEFORE_ACTION is a set point that says BEFORE DOING ACTIONS EXECUTE METHOD SET_ARTICLE - But if its a selective set of code - specify the actions to utilize the method call here SET_ARTICLE

  def show
    #byebug
  end
  def index
    @articles = Article.all                                                                         #Take Article class, using all method and gather all articles in the table and pass to INSTANCE Variable to be used in index page
  end
  def new
    @article = Article.new()
  end
  def edit
  end
  def create
    #very simple type of info pulling in debug sort of way.
    #render plain: params[:article]

    @article = Article.new(article_params)                   #Create method called by post call from form submit button chain methods from passed in params object to obtain desired fields and set them up to written to db
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
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end
  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private                                                                                            #Keyword PRIVATE indicates private methods beneath so they are not universal to the program

  def set_article                                                                                    #Method contains 1 line of code universal to 4 different actions SHOW, EDIT, UPDATE, DESTROY
    @article = Article.find(params[:id])                                                             #Take Article class and find passed in parameter ID and store to INSTANCE variable to be used outside of method
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
