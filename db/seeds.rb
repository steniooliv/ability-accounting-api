Accounting.destroy_all
User.destroy_all
Company.destroy_all
Customer.destroy_all
Invoice.destroy_all

Accounting.create!(id: 1, name: 'Sotec Contabilidade')
Accounting.create!(id: 2, name: 'GPena Contabilidade')
Accounting.create!(id: 3, name: 'Suporte Contabilidade')

User.create!(id: 1, name: 'Stenio Oliveira', email: 'steniooliv@gmail.com', password:'1', accounting_id: 1)
User.create!(id: 2, name: 'Gustavo', email: 'gustavo@gmail.com', password:'1', accounting_id: 2)
User.create!(id: 3, name: 'Talita', email: 'talita@gmail.com', password:'1', accounting_id: 3)

Company.create!(id: 1, name: 'Ability Informatica', accounting_id: 1)
Company.create!(id: 2, name: 'Mister Baby', accounting_id: 1)
Company.create!(id: 3, name: 'A3 Distribuidora', accounting_id: 2)
Company.create!(id: 4, name: 'Multipeixe', accounting_id: 2)
Company.create!(id: 5, name: 'Cartório', accounting_id: 3)
Company.create!(id: 6, name: 'Raio Imagme', accounting_id: 3)

Customer.create!(id: 1, name: 'Stenio Oliveira')

Invoice.create!(id: 1, number: 2346, serie: 'ADS', total_value: 4567, company_id: 1, customer_id: 1)
Invoice.create!(id: 2, number: 2347, serie: 'ASS', total_value: 2322, company_id: 1, customer_id: 1)
Invoice.create!(id: 3, number: 2348, serie: 'AFS', total_value: 5633, company_id: 2, customer_id: 1)
Invoice.create!(id: 4, number: 2349, serie: 'AWS', total_value: 7654, company_id: 2, customer_id: 1)
Invoice.create!(id: 5, number: 2340, serie: 'AAS', total_value: 5861, company_id: 3, customer_id: 1)
Invoice.create!(id: 6, number: 2341, serie: 'AQS', total_value: 1984, company_id: 3, customer_id: 1)
