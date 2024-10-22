//classe Autor
class Autor{
  //propriedades Autor
  var nome: String
  var nacionalidade: String
  var anoNascimento: Int

  //construtor da classe (executado quando um objeto é criado)
  init(nome: String, nacionalidade: String, anoNascimento: Int){
    self.nome = nome
    self.nacionalidade = nacionalidade
    self.anoNascimento = anoNascimento
  }
}

//Classe Livro
class Livro{
  //propriedades Livro
  var titulo: String
  var autor: Autor
  var anoPublicacao: Int
  var disponivel: Bool

  //construtor da classe
  //disponivel recebe um valor pois, se não for informado, o valor padrão é true
  init(titulo: String, autor: Autor, anoPublicacao: Int, disponivel:Bool = true){
    self.titulo = titulo
    self.autor = autor
    self.anoPublicacao = anoPublicacao
    self.disponivel = disponivel
  }

  //Métodos
  func emprestar(){
    //Verifica se está disponível
    if disponivel{
      disponivel = false
      print("O livro '\(titulo)' foi emprestado com sucesso.")
    } else {
      print("O livro '\(titulo)' não está disponível.")
    }
  }

  func devolver() {
      disponivel = true
      print("O livro '\(titulo)' foi devolvido.")
  }
}

//Classe Usuario
class Usuario{
  //Propriedades Usuario
  var nome: String
  var email: String
  //Lista de livros emprestados, será preenchida com objetos do tipo Livro caso emprestado
  var livrosEmprestados: [Livro] = []

  //construtor da classe
  init(nome: String, email: String) {
      self.nome = nome
      self.email = email
  }

  //Métodos
  func pegarEmprestado(livro: Livro){
    //Verifica se o livro está disponível, se sim adiciona na lista
    if livro.disponivel{
      livrosEmprestados.append(livro)
      livro.emprestar()
    } else {
      print("O livro '\(livro.titulo)' já está emprestado.")
    }
  }

  //Método que irá verificar se o mesmo título do livre está na lista de livros emprestados, caso verdadeiro ele remove utilizando o índice correto
  func devolverLivro(livro: Livro) {
      if let index = livrosEmprestados.firstIndex(where: { $0.titulo == livro.titulo }) {
          livrosEmprestados.remove(at: index)
          livro.devolver()
      } else {
          print("O usuário não possui o livro '\(livro.titulo)' emprestado.")
      }
  }
}

// Criando instâncias de autores
let autor1 = Autor(nome: "J.K. Rowling", nacionalidade: "Britânica", anoNascimento: 1965)
let autor2 = Autor(nome: "George Orwell", nacionalidade: "Britânico", anoNascimento: 1903)

// Criando instâncias de livros
let livro1 = Livro(titulo: "Harry Potter e a Pedra Filosofal", autor: autor1, anoPublicacao: 1997)
let livro2 = Livro(titulo: "1984", autor: autor2, anoPublicacao: 1949)
let livro3 = Livro(titulo: "Harry Potter e a Câmara Secreta", autor: autor1, anoPublicacao: 1998)

// Criando instâncias de usuários
let usuario1 = Usuario(nome: "Alice", email: "alice@example.com")
let usuario2 = Usuario(nome: "Bob", email: "bob@example.com")

// Empréstimos e devoluções
usuario1.pegarEmprestado(livro: livro1)  // Alice pega "Harry Potter e a Pedra Filosofal"
usuario1.pegarEmprestado(livro: livro2)  // Alice pega "1984"
usuario2.pegarEmprestado(livro: livro1)  // Bob tenta pegar "Harry Potter e a Pedra Filosofal", mas já está emprestado

//usuario1.devolverLivro(livro: livro1)    // Alice devolve "Harry Potter e a Pedra Filosofal"
//usuario2.pegarEmprestado(livro: livro1)  // Bob pega "Harry Potter e a Pedra Filosofal" após a devolução

// Ver os livros que Alice pegou emprestado
print("Livros emprestados por \(usuario1.nome):")
for livro in usuario1.livrosEmprestados {
    print("Título: \(livro.titulo), Autor: \(livro.autor.nome)")
}