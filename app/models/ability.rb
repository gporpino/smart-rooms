class Ability
  include CanCan::Ability

  def initialize(user)

    if user

      rooms_i_belongs = []
      user.rooms.each do |room|
          rooms_i_belongs << room.id
      end

      can :manage, User, :id => user.id
      can :show, User
      can :manage, Room, :owner_id => user.id
      can :read, Room, :id => rooms_i_belongs
      can :manage, Reservation
    else
      cannot :manage, :all
      can [:new, :create], User
    end

  end
end
