import React from 'react'
import ReactDOM from 'react-dom'
import { Socket } from 'phoenix'
import Board from './Board'
import Players from './Players'
import playerUI from '../playerUI'

class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      selectedTileId: null,
    }
  }

  componentDidMount() {
    const self = this;
    this.props.channel.on('update', new_state => {
      self.setState(new_state)
    })
  }

  tileClicked(id, e) {
    console.log('tileClicked', id)
    const player_owns_tile =
      this.state.tiles[id].owner == this.state.current_player_id

    if (this.state.selectedTileId) {
      // Moving or attacking
      if (player_owns_tile && this.state.selectedTileId !== id) {
        // Moving
        const unitCount = prompt('How many units do you wish to move? (This will end your turn.)')
        this.action('move', {
          from_id: this.state.selectedTileId,
          to_id: id,
          count: parseInt(unitCount)
        })
        this.cancelSelection()
        e.stopPropagation()
      } else if (this.state.selectedTileId !== id) {
        // Attacking
        this.action('attack', { from_id: this.state.selectedTileId, to_id: id })
        e.stopPropagation()
      }
    } else {
      if (player_owns_tile) {
        if (this.state.players[this.state.current_player_id].unplaced_units > 0) {
          // Placing units
          this.action('place_unit', { tile_id: id })
          e.stopPropagation()
        } else {
          // Selecting a tile to move to/attack
          console.log('selecting tile', id)
          this.setState({ selectedTileId: id })
          e.stopPropagation()
        }
      }
    }
  }

  cancelSelection() {
    this.setState({ selectedTileId: null })
  }

  action(type, payload) {
    payload = payload || {}
    payload.type = type
    console.log('action', payload)
    this.props.channel.push('action', payload)
  }

  endTurn() {
    this.cancelSelection()
    this.action('end_turn')
  }

  startGame() {
    this.action('start_game')
  }

  canStartGame() {
    return Object.values(this.state.players).filter((player) => player.active).length > 1
  }

  render() {
    return (
      <div className="Game">
        {this.state.winner_id &&
          <div className="Overlay">
            {playerUI[this.state.winner_id].name} wins!
          </div>
        }
        <div className="Display">
          {this.state.players &&
            <Players players={this.state.players} currentPlayerId={this.state.current_player_id} />
          }
          {this.state.turn > 0 &&
            <button className="Button" onClick={this.endTurn.bind(this)}>End Turn</button>
          }
          {this.state.turn == 0 &&
            <button className="Button" disabled={!this.canStartGame()} onClick={this.startGame.bind(this)}>Start Game</button>
          }
        </div>
        {this.state.tiles &&
          <Board tiles={this.state.tiles}
                 tileClicked={this.tileClicked.bind(this)}
                 cancelSelection={this.cancelSelection.bind(this)}
                 selectedTileId={this.state.selectedTileId} />
        }
      </div>
    )
  }
}

export default Game
