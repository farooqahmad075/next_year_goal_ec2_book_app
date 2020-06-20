<% #if user_signed_in? %>

 	<% #if @book.user == current_user %>
		<%= #link_to "Edit Book", edit_book_path(@book) %>
 		<%= #link_to "Delete Book", book_path(@book), method: :delete, data: {confirm: "Are you sure?" }%>
 	<% #end %>
	
 <% #end %>