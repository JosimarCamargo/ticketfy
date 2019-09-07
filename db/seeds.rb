# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Default Admin User
User.create!(email: 'admin@ticketfy', password: 'changeme')

# Tickets Samples
[
  {
    title: 'My fist ticket',
    status: 0,
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur suscipit aliquam justo, tristique vehicula arcu consequat vitae. Pellentesque accumsan ornare sagittis. Phasellus ut libero scelerisque arcu malesuada dignissim. Vestibulum maximus placerat ipsum sit amet ultricies. Nunc commodo magna in velit dapibus, eget elementum quam efficitur. Mauris enim est, posuere ac cursus eu, feugiat nec elit. Integer scelerisque sagittis turpis vel accumsan'
  },
  {
    title: 'Another ticket',
    status: 1,
    content: 'Mauris suscipit ac ante sit amet imperdiet. Pellentesque quis pretium mi, eget dignissim velit. Praesent gravida enim quis lorem bibendum, eget convallis odio molestie. Vivamus porttitor leo sed odio tincidunt, ac suscipit leo congue. Etiam ut nisl arcu. Mauris vitae justo diam. Sed sit amet fringilla odio. Morbi vitae posuere dui, ut lobortis sem. Etiam hendrerit justo sapien, ac dapibus tortor efficitur bibendum. Vivamus commodo eros nunc, sit amet pretium risus vulputate ac.'
  },
  {
    title: 'A solved ticket',
    status: 2,
    content: 'Cras commodo tincidunt consequat. Curabitur suscipit nulla arcu, id faucibus risus tempor sit amet. Mauris sed tellus id sapien mollis commodo. Maecenas commodo turpis in varius sagittis. Donec ornare, nisi quis auctor euismod, ipsum urna tincidunt lectus, fermentum venenatis lacus velit ac justo. Donec at rhoncus risus, vel consectetur dui. Fusce hendrerit nibh et urna mattis, ac blandit erat suscipit'
  }
].each { |ticket_params| Ticket.create(ticket_params) }
