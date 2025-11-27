"""add diet_allergies table

Revision ID: 17cbb706fa30
Revises: 2bfea85b5a9d
Create Date: 2025-11-27 14:21:42.942519

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '17cbb706fa30'
down_revision: Union[str, Sequence[str], None] = '2bfea85b5a9d'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
