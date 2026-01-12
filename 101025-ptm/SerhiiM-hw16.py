from collections import defaultdict

def group_tasks(tasks):
    tasks_groups = defaultdict(list)
    for task, category in tasks.items():
        tasks_groups[category].append(task)
    return dict(tasks_groups)

def list_tasks(categ_tasks, tasks_groups):
    for category, groups in tasks_groups.items():
        if categ_tasks.lower() == category:
            return tasks_groups[category]
    return "Категория указана не верно!!!"

tasks = {
 "task1": "работа",
 "task2": "учёба",
 "task3": "развлечения",
 "task4": "работа",
 "task5": "учёба"
}
tasks_groups = group_tasks(tasks)
print(tasks_groups)

categ_tasks = input("Enter a category: ")
print(list_tasks(categ_tasks, tasks_groups))