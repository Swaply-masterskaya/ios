# 🔹 Исключаем технические файлы из подсчета
ignored_patterns = [
  %r{^Gemfile\.lock$},
  %r{^Package\.resolved$},
  %r{^\.github/workflows/},
  %r{^fastlane/},
  %r{\.md$},
  %r{\.pbxproj$}
]

# 🔹 Собираем файлы
files = git.modified_files + git.added_files

# 🔹 Считаем изменения только по "важным" файлам
lines_changed = files.sum do |file|
  next 0 if ignored_patterns.any? { |pattern| file.match?(pattern) }

  diff = git.diff_for_file(file)
  next 0 unless diff && diff.patch

  additions = diff.patch.scan(/^\+(?!\+\+)/).size
  deletions = diff.patch.scan(/^\-(?!\-\-)/).size

  additions + deletions
end

# 🔹 Предупреждение о большом PR
if lines_changed > 600
  warn("⚠️ Большой PR: #{lines_changed} строк (без технических). Рекомендуется разбить на части")
end

# 🔹 Проверка описания PR
if github.pr_body.nil? || github.pr_body.strip.empty?
  warn("📝 Добавь описание PR")
end

# 🔹 Проверка наличия задачи (например SW-123)
unless github.pr_body =~ /SW-\d+/
  warn("🔗 Укажи ссылку на задачу (например SW-123)")
end