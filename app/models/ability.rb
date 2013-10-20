class Ability
  include CanCan::Ability

  def initialize(user)

    if user

      rooms_i_belongs = []
      user.associations.each do |room|
          rooms_i_belongs << room.id
      end

      can :manage, User, :id => user.id
      can :show, User
      can :manage, Room, :owner_id => user.id
      can :read, Room, :id => rooms_i_belongs
      can :manage, Reservation, :owner_id => user.id
      can :read, Reservation, :room_id => rooms_i_belongs
    else
      cannot :manage, :all
      can [:new, :create], User
    end

  end
end
