class OrgTeamsController < BaseController
  before_filter :login_required, :except => [:show, :index]
  before_filter :admin_required, :only => [:new, :edit, :update, :create, :destroy]


  # GET /org_teams
  def index
    @org_teams = OrgTeam.all
  end

  # GET /org_teams/1
  def show
    get_context
  end

  # GET /org_teams/new
  def new
    @org_team = OrgTeam.new
  end

  # GET /org_teams/1/edit
  def edit
    get_context
  end

  def join
    get_context
  end

  def create_membership
    get_context

    if @org_team.member?(current_user)
      flash[:error] = :you_are_already_a_member_of.l(:name => @org_team.name)
    else
      @org_team.users << current_user
      @org_team.save
      flash[:notice] = :you_are_now_a_member_of.l(:name => @org_team.name)
    end
    redirect_to org_team_path(@org_team)
  end

  # POST /org_teams
  def create
    puts "CREATE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1"
    ActiveRecord::Base.transaction do
      @org_team = OrgTeam.new(org_team_params)
      @category = Category.new(:name => @org_team.name)
      @category.save!
      @org_team.category = @category
      @org_team.save!
      redirect_to @org_team, notice: "Team #{@org_team.name} was successfully created."
    end
  end

  # PATCH/PUT /org_teams/1
  def update
    get_context
    if @org_team.update(org_team_params)
      redirect_to @org_team, notice: 'Org team was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /org_teams/1
  def destroy
    get_context
    @org_team.destroy
    redirect_to org_teams_url, notice: 'Org team was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_context
      @org_team = OrgTeam.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def org_team_params
      params[:org_team].permit(:name, :description)
    end
end
