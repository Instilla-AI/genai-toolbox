from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

app = FastAPI()

# CORS (facoltativo, utile per frontend o test esterni)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/mcp/")
async def get_toolbox():
    return {
        "type": "toolbox",
        "tools": [
            {
                "name": "echo",
                "description": "Ripete il messaggio",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "message": {"type": "string"}
                    },
                    "required": ["message"]
                },
                "run": "echo_tool"
            }
        ]
    }

@app.post("/mcp/tools/echo_tool")
async def echo_tool(request: Request):
    body = await request.json()
    message = body.get("message", "")
    return JSONResponse(content={"echo": message})

if __name__ == "__main__":
    import os
    port = int(os.environ.get("PORT", 3000))
    uvicorn.run("main:app", host="0.0.0.0", port=port)
