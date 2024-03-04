"""
hi.
"""

from litestar import Litestar, get


@get("/")
async def index() -> str:
    """hi."""
    return "Hello, world!"


@get("/books/{book_id:int}")
async def get_book(book_id: int) -> dict[str, int]:
    """hi."""
    return {"book_id": book_id}


app = Litestar([index, get_book])
