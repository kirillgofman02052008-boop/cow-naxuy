# cow naxuy

Приложение-прикол: тапаешь по корове с громкоговорителем — играет мелодия.

## Как получить .ipa

1. Создать репозиторий на GitHub (например `cow-naxuy`).
2. Залить туда все файлы из этой папки (включая скрытую `.github`).
3. Открыть вкладку **Actions** → слева **Build IPA** → кнопка **Run workflow**.
4. Подождать 5–10 минут, зайти в завершившийся запуск.
5. Внизу страницы, блок **Artifacts** → скачать **CowNaxuy-ipa**.
6. Распаковать архив — внутри `CowNaxuy.ipa`.
7. Закинуть `.ipa` в LiveContainer.

## Если `.github` не залилась

Создать файл вручную: **Add file → Create new file**, имя
`.github/workflows/build-ipa.yml`, и вставить туда содержимое
`.github/workflows/build-ipa.yml` из этой папки.

## Структура

- `Sources/` — код приложения (SwiftUI)
- `Resources/` — картинки и звук
- `project.yml` — описание проекта для XcodeGen (Xcode-проект генерируется автоматически при сборке)
- `.github/workflows/build-ipa.yml` — автосборка .ipa на серверах GitHub
