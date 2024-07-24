#!/usr/bin/env python3

import os

def write_structure_and_contents_to_file(base_dir, output_file):
    with open(output_file, 'w', encoding='utf-8') as out_file:
        out_file.write(f"СТРУКТУРА ПРОЕКТА:\n\n")
        for root, dirs, files in os.walk(base_dir):
            relative_path = os.path.relpath(root, base_dir)
            out_file.write(f"\nДиректория: {relative_path}\n")
            if dirs:
                out_file.write(f"  Поддиректории:\n")
                for d in dirs:
                    out_file.write(f"    {d}\n")
            if files:
                out_file.write(f"  Файлы:\n")
                for f in files:
                    out_file.write(f"    {f}\n")
                    file_path = os.path.join(root, f)
                    out_file.write(f"      Содержимое файла {f}:\n")
                    try:
                        with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
                            content = file.read()
                            out_file.write(f"{content}\n")
                    except Exception as e:
                        out_file.write(f"Не удалось прочитать файл: {e}\n")
                    out_file.write(f"{'-'*40}\n")

if __name__ == "__main__":
    base_directory = "."  # Текущая директория
    output_filename = "project_structure_and_contents.txt"  # Имя файла для вывода
    write_structure_and_contents_to_file(base_directory, output_filename)
    print(f"Структура проекта и содержимое файлов записаны в {output_filename}")