import { type DjangoGETResponse } from "./DjangoGETResponse"

export enum RosterLinkRole {
    Top,
    Jungle,
    Mid,
    Bot,
    Support,
    Substitute,
    Coach,
}

export interface RosterLinkTeamRedirectName {
    url: string
    op: string
}

export interface RosterLinkTeam {
    url: string
    team_name: string
    redirect_name: RosterLinkTeamRedirectName
}

export interface RosterLinkPlayer {
    display_name: string
    url: string
    link_url: string
}

export interface Tournament {
    url: string
    name: string
    date: Date
}

export interface RosterLinkRoster {
    url: string
    team: RosterLinkTeam
    tournament: Tournament
}

export interface RosterLink {
    player: RosterLinkPlayer
    role: RosterLinkRole
    roster: RosterLinkRoster
}

export interface ReducedRosterLink {
    player: RosterLinkPlayer
    role: RosterLinkRole
    link_url: string
}

export interface Roster {
    url: string
    team: RosterLinkTeam
    tournament: Tournament
    players: ReducedRosterLink[]
}


export interface RosterLinksResponse extends DjangoGETResponse<RosterLink> {

}

export interface RosterResponse extends DjangoGETResponse<Roster> {

}