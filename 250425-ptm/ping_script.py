import subprocess
import time

address = input("Введите адрес для пинга: ")
fail_count = 0

while True:
    result = subprocess.run(["ping", "-n", "1", address], capture_output=True, text=True)
    output = result.stdout

    if "время=" in output:
        ms = int(output.split("время=")[1].split("мс")[0].strip())
        print(f"Пинг: {ms} мс")
        if ms > 100:
            fail_count += 1
        else:
            fail_count = 0
    else:
        print("Пинг не прошёл.")
        fail_count += 1

    if fail_count >= 3:
        print("Пинг не удаётся или превышает 100 мс 3 раза подряд. Скрипт завершён.")
        break

    time.sleep(1)