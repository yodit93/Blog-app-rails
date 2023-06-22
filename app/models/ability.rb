class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all # users can read everything
    return unless user.present?

    can :manage, Post, author_id: user.id # logged users can manage their own posts
    can :manage, Comment, author_id: user.id # logged users can destroy their own comments
    return unless user.admin?

    can :manage, :all # admin can manage any post
  end
end
