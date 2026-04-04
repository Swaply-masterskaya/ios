lines_changed = git.insertions + git.deletions

if lines_changed > 400
  warn("⚠️ Большой PR: #{lines_changed} строк. Рекомендуется разбить на части")
end

# 🔹 Проверка описания PR
if github.pr_body.nil? || github.pr_body.strip.empty?
  warn("📝 Добавь описание PR")
end

# 🔹 Проверка наличия задачи (например SW-123)
unless github.pr_body =~ /SW-\d+/
  warn("🔗 Укажи ссылку на задачу (например SW-123)")
end