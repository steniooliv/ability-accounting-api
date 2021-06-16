Accounting.destroy_all
User.destroy_all
Company.destroy_all
Customer.destroy_all
Invoice.destroy_all

Accounting.create!(id: 1, name: 'Sotec Contabilidade')
Accounting.create!(id: 2, name: 'GPena Contabilidade')
Accounting.create!(id: 3, name: 'Suporte Contabilidade')

User.create!(id: 1, name: 'Stenio Oliveira', email: 'steniooliv@gmail.com', password:'1', password_confirmation:'1', accounting_id: 1)
User.create!(id: 2, name: 'Gustavo', email: 'gustavo@gmail.com', password:'1', password_confirmation:'1', accounting_id: 2)
User.create!(id: 3, name: 'Talita', email: 'talita@gmail.com', password:'1', password_confirmation:'1', accounting_id: 3)

Company.create!(id: 1, name: 'Ability Informatica', number: 12456789000122, accounting_id: 1)
Company.create!(id: 2, name: 'Mister Baby', number: 12456789000122, accounting_id: 1)
Company.create!(id: 3, name: 'A3 Distribuidora', number: 58125678000122, accounting_id: 2)
Company.create!(id: 4, name: 'Multipeixe', number: 35157462000122, accounting_id: 2)
Company.create!(id: 5, name: 'Cartório', number: 12548752000122, accounting_id: 3)
Company.create!(id: 6, name: 'Raio Imagme', number: 12456789000122, accounting_id: 3)

Customer.create!(id: 1, name: 'Stenio Oliveira')

# Invoice.create!(id: 1, customer_id: 1, company_id: 1, number: 1234, serie: "001", model: "A", type_record: "NFE", type_movement: "E", date_issue: Date.new(2021, 06, 11), date_departure: Date.new(2021, 06, 11), access_key: "12549846514685195976516489879846548987651234", total_product: 1592.56, discount_value: 10.10, expenses_value: 10.20, shipping_value: 10.30, safe_value: 10.40, icms_base: 1592.56, icms_value: 100.50, sticms_base: 100.50, sticms_value: 10.50, ipi_base: 10.60, ipi_value: 10.70, pis_base: 10.80, pis_value: 10.90, cofins_base: 11.00, cofins_value: 11.10, invoice_value: 1950.50)

Invoice.create(id: 1, customer_id: 1, company_id: 1, number: 1010, serie: 'A', model: "AA", type_record: "AAA", type_movement: "E", date_issue: DateTime.new(2021,6,11), date_departure: DateTime.new(2021,6,11), access_key: "1234567891234567891345678912345678912345678", total_product: 10.10, discount_value: 10.10, expenses_value: 10.10, shipping_value: 10.10, safe_value: 10.10, icms_base: 10.10, icms_value: 10.10, sticms_base: 10.10, sticms_value: 10.10, ipi_base: 10.10, ipi_value: 10.10, pis_base: 10.10, pis_value: 10.10, cofins_base: 10.10, cofins_value: 10.10, invoice_value: 10.10)

InvoiceProduct.create(product_id: 1, description: 'TV 4K LED 49MU6100', quantity: 1, price_unitary: 2499, price_total: 2499, discount_value: 10, expenses_value: 10, shipping_value: 10, safe_value: 10, icms_cst_csosn: "A", icms_base: 10, icms_value: 10, sticms_base: 10, sticms_value: 10, ipi_cst:'a', ipi_base: 10, ipi_value: 10, pis_cst: 'A', pis_base: 10, pis_value: 10, cofins_cst: 'A', cofins_base: 10, cofins_value: 10, invoice_id: 1)


AdminUser.create!(email: 'steniooliv@gmail.com', password: 'legiap', password_confirmation: 'legiap') if Rails.env.development?