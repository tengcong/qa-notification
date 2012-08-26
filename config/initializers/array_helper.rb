def desc_list_by_updated_at list
  list.sort_by(&:updated_at).reverse
end
