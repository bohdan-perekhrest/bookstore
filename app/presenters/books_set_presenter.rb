class BooksSetPresenter
  def initialise(books)
    @books = books.map{ |book| BookPresenter.new(book) }
  end

  def set
    @books.each_slice(4).to_a
  end
end
