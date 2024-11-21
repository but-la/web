/github/workspace/shortener/pkg/store/store.go
package store

import (
	"context"

	"github.com/dbut2/butla/shortener/pkg/models"
)

type Store interface {
	LinkStore
	UserStore
}

type LinkStore interface {
	SetLink(ctx context.Context, link models.Link) error
	GetLink(ctx context.Context, code string) (models.Link, bool, error)
}

type UserStore interface {
	SetUser(ctx context.Context, user models.User) error
	GetUser(ctx context.Context, username string) (models.User, bool, error)
}

type GenericStore[T any] interface {
	Set(ctx context.Context, val T) error
	Get(ctx context.Context, key string) (T, bool, error)
}

```
```markdown
/github/workspace/shortener/pkg/store/README.md
# Store Interface for Shortener

This Go file defines interfaces that must be implemented by any storage mechanism used in the Shortener application for handling link and user data.

## Interfaces:

- `Store`: A combination of both `LinkStore` and `UserStore` interfaces.
- `LinkStore`: Interface for managing link-related persistent operations.
  - `SetLink`: Store a given link in the data store.
  - `GetLink`: Retrieve a link by its code from the data store.
- `UserStore`: Interface for user-related persistent operations.
  - `SetUser`: Store a given user in the data store.
  - `GetUser`: Retrieve a user by the username from the data store.
- `GenericStore`: A generic interface allowing for type-safe implementations of storage operations for any custom types.

## Usage:

- Implement the `LinkStore` and `UserStore` interfaces in storage providers (for example, SQL databases, in-memory stores, or cloud-based datastores).
- Pass the implementation to parts of the application that require data storage and retrieval.
- Use context-aware methods (`ctx`) to allow for operation cancellation and timeout handling.

These interfaces separate storage logic from the application's core functionality, enabling easy swapping or extension of storage backends without altering the business logic.