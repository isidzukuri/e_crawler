class Basket

  def initialize(session)
    @session = session
  end

  def items
    if session[:products]
      session[:products]
    else
      session[:products] = Set.new
    end
  end

  def add(id)
    items << id.to_i
    session[:products] = items
  end

  def remove(id)
    items.delete(id.to_i)
  end

  def empty
    session.delete(:products)
  end

  private 

  attr_accessor :session

end
