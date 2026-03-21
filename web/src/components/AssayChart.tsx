import { useEffect, useState } from 'react'
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/Card'
import { api } from '@/lib/api'
import type { Assay } from '@/types'

interface AssayChartProps {
  drillholeId: string
  holeName: string
}

export function AssayChart({ drillholeId, holeName }: AssayChartProps) {
  const [data, setData] = useState<Array<{ depth: number; value: number; element: string }>>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const fetchAssays = async () => {
      try {
        setLoading(true)
        const response = await api.getAssays(drillholeId, 'Au')
        
        // Format data for Recharts
        const chartData = response.data.map((assay: Assay) => ({
          depth: assay.from_depth,
          value: assay.value,
          element: assay.element
        }))

        setData(chartData)
        setError(null)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Error loading assays')
        console.error('Error fetching assays:', err)
      } finally {
        setLoading(false)
      }
    }

    if (drillholeId) {
      fetchAssays()
    }
  }, [drillholeId])

  if (loading) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Assay Profile - {holeName}</CardTitle>
          <CardDescription>Loading chart...</CardDescription>
        </CardHeader>
      </Card>
    )
  }

  if (error || data.length === 0) {
    return (
      <Card className="border-yellow-200 dark:border-yellow-800">
        <CardHeader>
          <CardTitle className="text-lg">Assay Profile - {holeName}</CardTitle>
          <CardDescription className="text-yellow-600 dark:text-yellow-400">
            {error || 'No assay data available'}
          </CardDescription>
        </CardHeader>
      </Card>
    )
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-lg">Assay Profile - {holeName}</CardTitle>
        <CardDescription>Gold (Au) concentration vs. depth</CardDescription>
      </CardHeader>
      <CardContent>
        <ResponsiveContainer width="100%" height={300}>
          <LineChart data={data}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis 
              dataKey="depth" 
              label={{ value: 'Depth (m)', position: 'insideBottom', offset: -5 }}
            />
            <YAxis 
              label={{ value: 'Au (ppb)', angle: -90, position: 'insideLeft' }}
            />
            <Tooltip 
              contentStyle={{
                backgroundColor: '#f5f5f5',
                border: '1px solid #ccc',
                borderRadius: '4px'
              }}
            />
            <Legend />
            <Line 
              type="monotone" 
              dataKey="value" 
              stroke="#ff7800" 
              name="Au Grade"
              dot={false}
              isAnimationActive={false}
            />
          </LineChart>
        </ResponsiveContainer>
      </CardContent>
    </Card>
  )
}
