require_relative 'store'

# ReportingSystem is basically an interface for store methods

# 1st version, with dynamically defining methods

class ReportingSystem
  def initialize
    @store = Store.new
    # récupère toutes les méthodes de la classe Store
    @store.methods.grep(/^get_(.*)_desc/) { ReportingSystem.define_report_methods_for $1 }
  end

  # define_method permet de créer dynamiquement en run time une méthode dans une classe
  def self.define_report_methods_for (item)
    define_method("get_#{item}_desc") { @store.send("get_#{item}_desc")}
    define_method("get_#{item}_price") { @store.send("get_#{item}_price")}
  end
end

# 2nd version, with ghosts methods

class ReportingSystem
  def initialize
    @store = Store.new
  end

  # Surcharge de la méthode "method_missing" qui lève habituellement une exception : NoMethodFound.
  # Cette méthode est héritée par toutes les classes Ruby
  # En la surchargeant comme cela, nous pouvons appeler toutes les méthodes de Store si la méthode appelée
  # existe bel et bien dans Store.
  def method_missing(name, *args)
    # On appelle super si la méthode fournie n'existe pas dans Store.
    # En appelant super on aura le comportement originel de method_missing
    super unless @store.respond_to?(name)
    @store.send(name)
  end
end

# 3rd version, hybrid approach

class ReportingSystem
  def initialize
    @store = Store.new
  end

  # Approche hybride permettant de créer une méthode si elle n'existait pas déjà dans la classe.
  # Nous augmentons ainsi les performances par rapport à la second version, tout en économisant des lignes de codes
  def method_missing(name, *args)
    super unless @store.respond_to?(name)
    define_method(name) { @store.send(name) }
    # Appel de la méthode juste pour cette fois. Plus tard, la méthode nouvellement crée sera directement appelée.
    @store.send(name)
  end
end

#Example

rs = ReportingSystem.new
puts "#{rs.get_piano_desc} costs #{rs.get_piano_price.to_s.ljust(6,'0')}"
