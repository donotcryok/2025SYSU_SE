@echo off
echo ===== CASE工具环境验证 =====
echo.

echo 1. 检查Java环境...
java -version 2>nul
if %errorlevel% neq 0 (
    echo [错误] Java未正确安装或未添加到PATH
    echo 解决方案：
    echo - 重新安装Java并确保勾选"Add to PATH"
    echo - 手动配置JAVA_HOME和PATH环境变量
    goto :error
)
echo [成功] Java环境正常
echo.

echo 2. 检查Python环境...
python --version 2>nul
if %errorlevel% neq 0 (
    echo [错误] Python未正确安装或未添加到PATH
    echo 解决方案：
    echo - 重新安装Python并确保勾选"Add python.exe to PATH"
    goto :error
)
echo [成功] Python环境正常
echo.

echo 3. 检查Pyreverse...
pyreverse --help >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Pyreverse未正确安装
    echo 解决方案：
    echo - 运行：pip install pylint
    goto :error
)
echo [成功] Pyreverse可用
echo.

echo 4. 检查Graphviz...
dot -V 2>nul
if %errorlevel% neq 0 (
    echo [错误] Graphviz未正确安装或未添加到PATH
    echo 解决方案：
    echo - 检查安装路径：C:\Program Files\Graphviz\bin
    echo - 手动添加到PATH环境变量
    goto :error
)
echo [成功] Graphviz环境正常
echo.

echo 5. 检查PlantUML...
if exist "plantuml.jar" (
    java -jar plantuml.jar -version 2>nul
    if %errorlevel% neq 0 (
        echo [错误] PlantUML无法运行
        echo 解决方案：
        echo - 检查Java是否正确安装
        echo - 重新下载plantuml.jar文件
        goto :error
    )
    echo [成功] PlantUML可用
) else (
    echo [错误] 找不到plantuml.jar文件
    echo 解决方案：
    echo - 确保plantuml.jar在当前目录
    echo - 重新下载PlantUML JAR文件
    goto :error
)
echo.

echo ===== 所有工具验证成功！ =====
echo 环境搭建完成，可以开始UML建模了。
goto :end

:error
echo.
echo ===== 环境验证失败 =====
echo 请参考上述解决方案重新配置相应工具。
echo 如需帮助，请检查以下常见问题：
echo 1. 是否以管理员权限安装软件
echo 2. 是否重启命令提示符以刷新PATH
echo 3. 是否正确配置环境变量

:end
pause
