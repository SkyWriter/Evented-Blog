class AddPost < BusinessEvent
  def after_initialize
    @post = Post.new(:text => @params[:text])
  end
  
  def process
    save(false) and return false unless @post.valid?
    unconditional_process
    save(true)
  end
  
  def unconditional_process
    @post.save!
  end
end