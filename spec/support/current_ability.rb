class GodAbility
  include CanCan::Ability

  def initialize
    can :manage, :all
  end
end

def current_ability
  GodAbility.new
end
