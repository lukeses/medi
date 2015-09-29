class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can [:read, :create, :update, :destroy, :admin_new, :admin_create, :admin_update, :toggle_approve, :index_doctors], User
        can [:read, :create, :update, :destroy], Clinic
        can [:read, :create, :update, :destroy], Work
        can [:read, :create, :update, :destroy], Workhour
        can [:read, :create, :update, :destroy], Visit
      elsif user.patient?
        can [:read, :create, :update, :destroy], Visit
      elsif user.doctor?
        can [:read, :create, :update, :destroy], Workhour
        can [:read, :index_visits_for_doctor], Visit
      end




    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
