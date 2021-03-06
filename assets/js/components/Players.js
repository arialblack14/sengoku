import React from 'react'
import Player from './Player'

const Players = (props) => {

  const players = Object.keys(props.players).map(Number).map((player_id) => {
    return <Player key={player_id}
                   id={player_id}
                   className="Player"
                   current={props.currentPlayerId == player_id}
                   color={props.players[player_id].color}
                   active={props.players[player_id].active}
                   ai={props.players[player_id].ai}
                   name={props.players[player_id].name}
                   unplacedArmies={props.players[player_id].unplaced_units} />
  })

  return (
    <ul className="Players">
      {players}
    </ul>
  )
}

export default Players
